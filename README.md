# Rewards Referral System - Rails Backend  

## Table of Contents  
[Overview](#overview)  
[Features](#features)  
[Installation](#installation)  
[Environment Variables](#environment-variables)  
[Dependencies](#dependencies)  

## Overview  
This is the backend API for the **Rewards Referral System**, built with **Ruby on Rails**. It provides authentication, referral tracking, and reward distribution. Users can refer friends via email, and successful sign-ups earn them rewards.  

## Features  
✅ **User Authentication** (Sign up/Login)  
✅ **Referral System** (Users can refer friends via email)  
✅ **Reward Tracking** (Users earn rewards for successful referrals)  
✅ **Email Notifications** (Automated emails for referrals and rewards)  
✅ **RESTful API** for frontend integration  

## Installation  
Make sure you have **Ruby** and **Rails** installed. Then, follow these steps:  

1. Clone the repository:  
   sh  
   git clone https://github.com/PriyanGuptadev/Referral_task_backend.git  
   cd your-repo  
    
2. Install dependencies:  
   sh  
   bundle install  
    
3. Set up the database:  
   sh  
   rails db:create db:migrate db:seed  
    
4. Start the Rails server:  
   sh  
   rails server  
    

## Environment Variables  
Create a .env file in the root directory and add the following:  
EMAIL_USERNAME=testuser@yopmail.com
EMAIL_PASSWORD=kglklksfdlkl
REDIS_URL=redis://127.0.0.1:6379/0

## Dependencies  
Rails – A powerful web framework for building robust applications.
Devise & Devise Token Auth – Handles user authentication and token-based authentication for APIs.
Sidekiq – A background job processor for handling asynchronous tasks efficiently.
MailCatcher – A tool used in development to test and preview emails locally.
Rack-CORS – Middleware for handling Cross-Origin Resource Sharing (CORS), allowing secure API access from different origins.
-