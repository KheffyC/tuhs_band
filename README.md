# Tulare Union Music Website

## About 
This project was designed and created for Tulare Union Marching Band. Though this is an ongoing project for the next few years, the basis of it is a hub of information for all students enrolled in the music programs at Tulare Union. All Itineraries, Syllabus, Fundraisers, and Contact information can be readily found for all parents and students alike. 

Features soon to come include: 
<ul>
  <li>Practice Hub - A place to follow along to onscreen music of the current selections for the season.</li>
  <li>Fundraiser Links and Events</li>
  <li>Booster Page - A page dedicated to all the parents that endlessly give support to our students</li>
  <li>Donation Page - Linked directly with Stripe (pending booster approval)</li>
</ul>

## Requirements
This project currently requires:

* Rails 7.1
* Ruby 3.1 or newer
* PostgreSQL
* Node 16.14+ or 18+, and Yarn 1.x

A .devcontainer is included with the project if you are running Docker locally on your machine and have devcontainers installed on VSCode. This is a quick way to run all necessary requirements and does not require you to have Rails or Ruby installed on your local machine. 

### Database creation
Please ensure that in database.yml you configure username and password to match the postgres default username/password

## Action Mailer 
In order for Action Mailer to be configured properly, please follow the steps to include smtp settings for gmail or your chosen provider. This will include a passkey that will need to be saved in Rails.credentials where it is protected with a Master.key

### Deployment 
** This app is currently deployed on Hatchbox.io using Digital Ocean as its provider.

Once the repo is cloned onto your machine, simply build your container using the dockerfile included in the .devcontainer folder

type ./bin/dev to begin the project. 

## What is included? 

* Simple Form 
* Invisible Captcha - Honey Pot for Bots submitting your contact form
* aws-sdk-s3 - Configured in Rails.credentials with AWS secrets
* PostgreSQL
* Importmaps for JS
* Tailwind for styling 
* Administrate Gem for user friendly admin functions
* Devise - User Authentication for Admin and Practice sessions