# Compliments

Sometimes it's nice to be thankful.

![How Compliments looks](https://s3.amazonaws.com/f.cl.ly/items/1H0T0D1B163a1r0z2V0b/Screen%20Shot%202015-10-01%20at%2012.34.58%20PM.png)

## Features
- Send a compliment to someone
- Receive a compliment from someone
- See all the compliments everyone sends to each other
- See all the compliments you've received over time
- Like a compliment someone sent to someone else
- Record a memorable quote from someone for posterity

## Integrations

Compliments integrates with Slack. You can use the `/quote "Text" - @username` 
command to create a new quote which will be attributed to the person associated
with that username via the Slack API.

## Authentication

We use Google OAuth2 to simplify authentication (a bit) and avoid creating a new 
set of credentials for such a small app. This will be very convenient to you if 
you have a Gmail or Google Apps account, not so much if you don't.

You'll need to create a Google API console project for your own hosted version of 
Compliments in order to sign in. You can find [a step-by-step guide here](https://github.com/zquestz/omniauth-google-oauth2#google-api-setup).

## How to get set up

After you clone the repository locally, there are a few steps to get a local 
version running.

- Run ./bin/setup
- Update the .env file with the correct environment variables (see the file)
- Das it!