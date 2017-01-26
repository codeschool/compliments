class SlashCommand
  def initialize(data)
    @data = data
  end

  def issuer
    @issuer ||= User.find_or_create_from_slack_id(@data[:user_id])
  end

  def text
    @data[:text]
  end

  class Quote < SlashCommand
    def quote
      text.split("@").first.strip
    end

    def quoter
      issuer
    end

    def quotee
      @quotee ||= User.find_or_create_from_slack_username(quotee_slack_username)
    end

    private

    def quotee_slack_username
      text.split("@").second.strip
    end
  end

  class Compliment < SlashCommand
    def compliment
      text.split(" ").drop(1).join(" ")
    end

    def complimenter
      issuer
    end

    def complimentee
      @complimentee ||= User.find_or_create_from_slack_username(complimentee_slack_username)
    end

    private

    def complimentee_slack_username
      text.split(" ").first.gsub(/@/,'')
    end
  end
end
