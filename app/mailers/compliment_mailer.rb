class ComplimentMailer < ActionMailer::Base
  default from: "compliments@codeschool.com"

  def notify(compliment)
    @compliment = compliment

    mail(to: @compliment.complimentee.email, subject: "Hey, #{@compliment.complimenter} said something nice about you!")
  end
end
