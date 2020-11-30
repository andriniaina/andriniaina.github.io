---
title: "My Giant Data Quality List"
date: 2020-12-01T12:36:40+02:00
draft: false
toc: false
images:
tags:
  - data science
---

> This text is not from me and I am not taking credit for it
> [original location](https://docs.google.com/document/d/19THZHWUQkxHg4t5kToRnEnOb7VKcye6Gs046meXCtng/edit)

I have some bad news for you.


Something in the data you used in your last project is wrong. You just don’t know it yet.


*“But, no! I got that data from the UI team. They said it was reviewed!”*


Congratulations. You can tell everyone that while you are being walked respectfully out of the building because your new marketing model caused $200,000 in lost revenue. Don’t blame Google because you thought Coffeyville, Kansas was a meaningful predictor when it is just the default geocentric center of the United States.


No, it is not another team’s fault. It is not the rushed timeline’s fault. It is not some great universal struggle that is impossible to overcome. The quality of the product you create is YOUR responsibility. The inputs and the outputs belong to YOU.


Welcome to the thankless world of data quality.


There are different levels of investment and effort that you can put into quality control. At the very least, you should keep a series of lists, around each data source, for errors that you have run into so that you can prevent the same error from happening twice. If you don’t already have something like that in place, I can give you a jump start.


Here is my small checklist for data quality. It is most useful at the start of a project, right after receiving data. You will find it is clear documentation to show your customer, enabling them to sign off on the items they are OK with you not testing - especially if they are insistent you must work within too few billable hours. You will not, however, find it useful if you are reading this in bed, as the ghosts of old untested data haunt you.


This is a shared effort - I would love to hear what things you run into. If you have any items that you’d like to add below, please let me know in the comments. I will try to keep a living document updated here.


Thank you for reading!


Chapter 1 : General Structure
===

* Is there an established map of the database?
    * Is it visible to all users?
    * Is there a public strategy of how it is tested for truth?
    * Are there known party(ies) responsible for updating it when there are structural * changes?
    * How often is it updated?
    * When is the next scheduled update?
    * Is there a change log to track prior changes?
    * Is there a group of humans you can go to with questions?
    * Is there a group of humans you can go to with general conversational topics?
        * The user list from a DBA is great for this.
        * Consider having a monthly meeting and yearly summit per database.
    * If the source of data is an application or form, is there a map from every entry * field to the corresponding field in the database?
* Capacity / Uptime
    * How concerned should you be with locking up the database with poorly written queries?
    * Who do you go to when it is dead?
    * Is the data backed up / archived anywhere?
        * For how long?
        * Do you remove old values from the production database after archiving?
    * Are queries logged?
    * How often is the database refreshed, if it is part of an ETL?
        * Automatically check, at the appropriate time, if it has been updated. Have a plan in * place for when it is inevitably not updated.
    * What is the official way to request access to the database?
    * Is there a time-out process of old user ID’s?
        * Have a plan in place for when an automated procedure’s stored credentials are suddenly invalid.
* Tables
    * Is there any rhyme or reason to the naming of tables?
    * If there are very similar tables (ie. CUSTOMER, CUSTOMER_NEW, CUSTOMER_NEW_NEW), do the alternates need to exist?
    * Is this table “one row that is constantly kept updated” or “one row for each time the data changes”?
* Joins
    * Should there be at least one “Child” for every “Parent”?
    * Is there a maximum expected “Children” for every “Parent”?
    * Should there be “Children” who don’t have “Parents”?
    * Is every table relatable to every other table?
    * On joining fields
        * Do the field types match, or do you need to do a conversion?
* Queries / Processes
    * Is the query properly notated?
        * With the code removed, the notes should be copy and paste-able to a non-technical * business partner.
        * The notes should represent reality. Please.
    * Is it possible to do an “anti-query”?
        * Reverse your filters, but mirror your production process. In high value pipelines, this can be a huge preventative measure for errors, and an easy way to provide "free" extra value.
    * Is it possible to do the query by hand on a small subset of records?
        * If so, do this periodically. Seriously. I know you got into this line of business to not do this stuff manually, but doing this periodically can help verify all systems are working properly.
        * Is the process entirely automated?
        * If not, don’t launch.
        * This includes any of the tests below that say “periodically”, if possible.
    * Is it possible to store the results of every query, along with a timestamp of run (especially as part of an ETL process?)
    * Are you choosing a “whitelist” approach, or a “blacklist” approach?
    * If there are changes after launch - will you be applying those changes to previous projects, or leaving them in place with old (and potentially inaccurate) data?

Chapter 2 : Data Types
====

* All
    * Are null values allowed?
    * Are the fields expected to change over time?
        * If the answer is “no”, take hashes of lines at the time of development and test periodically to see if they change.
        * If the answer is “yes”, take extracts with timestamps in the name and only use those (instead of production) for reproducibility.
    * Expert level - Create a X / Y grid of every field against every other field. Have all parties involved in development (especially the humans that are the source of the data) write assumptions and rules that come up in each cell (if this field is “beer” this other field should be “$5.99”)
        * Document all of these.
            * If something looks wrong and the customer says “that’s ok”, DOCUMENT THIS
                * With audio evidence if possible
                    * Video isn’t bad either

* General Text (Free entry)
    * If there is a default size, why is the default size set to the size it is?
    * Is the field having an identity crisis - does it only contain integers, dates, locations, etc.?
        * If so - should it be converted to the correct type?
            * What do you do with those that can’t be converted?
    * Does the text contain special characters that will cause it to print strangely * (line-break)?
    * Does the text contain special (or international) characters? Should it?
    * Is there a list of “stop words” that should be applied?
        * Especially inappropriate words. Don’t let an f-bomb get into a shareholder report.

* Categorical Text (Unique list of values)
    * Store the unique values at the time you are developing, and the counts of each value.
        * Periodically test for new/missing values. Have a plan in place for when this inevitably happens.
        * Periodically test for wild changes in distribution.
            * Communicate these to anyone who will listen. This will make you a hero.
        * Provide this list to stakeholders during development. This is always interesting, * because often it is vastly different than their estimate.
    * If there are multiple categorical fields, is there an hierarchy that is documented * and should be followed (if veh_type is “car”, then veh_brand can only be “audi”, “ford”, “toyota” etc.)
        * Have a plan in place for when this inevitably breaks.
    * Is the field indexed for fast grouping?
    * If the values are text numbers (one, two, three) - should they be converted to * integers (1, 2, 3)?

* Boolean (True/False)
    * If these represent a “switch” in the process, should the downstream impact also be represented in data? (if override_price=0 then discount_price should never be null)
    * Store the distribution at the time of developing, and periodically test for changes.
        * Communicate these to anyone who will listen.
* ID (Keys, AutoNum)
    * Is the ID an AutoNum?
        * Are there missing values?
    * Is the ID a complex key?
        * Do characters in the complex key relate to the data in any way?
            * Periodically test that this remains true.
    * Are duplicates allowed?
    * Are you operating under the assumption that the ID for any given record will never change (maintaining an extract or join to a private table)?
        * Have a plan in place for when they inevitably do.
    * If you remove the ID from the equation, are there any two completely identical rows?
* General Number/Integer
    * Does null = 0?
    * Are negative values expected?
    * Are decimals expected?
        * If not, is there rounding occurring upstream?
        * What are the rounding rules?
    * Is there a maximum/minimum expected value?
        * Record the minimum and maximum value at the time of development. Periodically test to see if this record has been broken.
    * Is there an expected distribution?
        * Periodically test to see if this has changed.
    * Is the number secretly categorical (only certain allowed values)?
        * Does the number increase in steps instead of linearly (100, 150, 200, 250…)
    * Is the number secretly a phone number or zip code?
    * Is there any chance that the number has been cut off to fit in a smaller field (I’m * looking at you, Smallint).
    * Is any number field the result of math on other number fields (price*tax=total)
    * Is there a business preferred format for showing numbers (commas, negative signs)
* Currency
    * Is there an assumed currency?
        * If not, is there a categorical field that will tell you what currency it is?
        * If the record also has a “country” - does the currency match the country?
        * Are you converting this currency to a central currency for data interpretability?
            * Store the conversion rates at the time of development.
    * Is there a maximum sane currency?
        * Record the maximum and test frequently. Have a plan in place for when it is * inevitably broken.
    * Does null = 0?
    * Does the value represent a “current” value, or a “point in time” value?
    * Are their negative values?
        * Does negative represent a debit or a credit to the company?
* General Contact Information
    * Is there a schedule for updating contact information?
    * When was the information last updated?
    * When was the information last successfully used?
    * If you use this information for any purpose, store the information at the time of * use, and the reason for use. If possible, get as many employees as possible to do * this in the same location using the same format.
    * Do any two customers have the same piece of contact information?
    * Does any contact information match your own company/office information?
    * Does any customer’s information match that of a current or former employee?
    * Is there a no-marketing list that you should be aware of? Ask multiple people and * get excited when there are multiple answers!
* Phone Numbers
    * Is there an assumed country code?
        * If not, is the country code stored in another field?
        * Do not assume the country of residence is the country code of the phone number.
        * Does the phone number follow the rules of that country code?
    * Is there an assumed area code?
        * Is the area code a toll free area code?
        * Is the area code a legitimate area code?
        * Is the phone number stored as text?
        * Is there any rhyme or reason to the formatting of the phone number?
        * What do you do with numbers that do not match that format?
    * Are you removing “bogus” phone numbers (All the same digits, counting up, etc.).
    * If there is a dialer campaign that returns invalid phone numbers, is anything being * done with that information?
* Mailing Address
    * Is there an assumed country?
        * If not, is the country stored in another field?
    * Is the address free entry text, or cleaned via a service?
        * If it is cleaned, what happens to un-cleanable records?
    * Is the Postal Code -> State/Region -> Country strictly enforced?
    * Is the mailing address in an expected area of business?
    * Is there an additional “APT” or “PO BOX” field? Should you be aware of this?
* Sensitive PII
    * Are these fields humanely appropriate for modeling or analysis (ethnicity, income)?
    * Do you need to be aware of HIPAA guidelines?
* Financial Information
    * God help you if your company is storing unmasked financial information.
    * Did two different customers make a transaction with the same credit card?
* Date / Time
    * Is this a timestamp field?
        * Is the time being stored with an assumed time zone?
    * Store the minimum date-time during development.
        * Periodically check to see if this has changed.
    * Are there any dates with missing information?
    * Are there records outside business hours?
    * Are there any fields that look like they were entered before their timestamp (people * trying to create records in the past)?
    * Are there any dates that are in the future?
    * Do you need to have a specific game plan for leap years?
    * Do you need to have a specific game plan for holidays?
    * When aggregating by date or hour, are there any outliers?
        * Communicate this to stakeholders as soon as possible.
        * Check this frequently - it’s valuable information and will make you famous when you * catch something.
    * If there are multiple date fields, should they have an order of operations (field2 * should always be after field1).
    * Does everyone know what “biweekly” means?
    * Does everyone know what “midnight” means?
    * Is there a business preferred date format?
    * For forecasting purposes - keep a seperate table telling you what dates to NOT take * into account when training forecast models. IE - Hurricanes, marketing campaigns, * giant international pandemics.
    * Do you have a plan for daylight savings time?
