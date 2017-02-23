# Project 2: Open Data App - an RShiny app development project

## Project Title: Un-Mate: Go find out which University fits you best!

+ Term: Spring 2017

+ Team #10

### Team Members

+ Jiahui Tian
+ Yue Jin
+ Qingyuan Zhang 
+ Tongyue Liu
+ Yijia Pan

### Link: 

### Background

Now, more and more international students are choosing to study in America. It's reported that more than 1,000,000 international students studied at U.S. colleges and universities in 2016/2017. However, many of them complain that it's difficult to find satisfying universities when they apply for schools. There are two reasons. First, it may cost them a lot of time to collect all the information about these universities online. Second, though they can get some information online, it's still hard for them to get exact details and comprehensively learn about these universities. In order to solve these problems, our team develop an application called Uni-Mate, which enables international students to discover and compare schools. It can help users filter and rank universities based on their own preferences and output interactive map & plots to show the characters of these universities.

### Project summary

This project explores and visualizes 272 universities in America by using the data on ([College Scorecard Database](https://collegescorecard.ed.gov/data/documentation/)), ([2016 Forbes Ranking](data/ranking_forbes_2016.csv)), ([HappyScore Data](data/Happinessdata.csv)) and ([Crime Data](CrimeData_final.csv)). We created a Shiny App to help users discover and compare universities. 

+ Filter & Rank——easily discover and compare the universities that meet users' requirements

Two filter parts. One part is the basic filter: they can choose universities upon "Major", "Type of School" and "Type of City". The other part is the advanced filter: they can give their weights to "Academic Performance", "Average Cost", "Earning & Jobs", "Social Security" and "Life Quality". 

Two ranking options. One option is based on "The 2016 Forbes University Rankings". The other one is using the weights users have given before to calculate the rank of these universities. 

+ Map & Plot——vividly show the characters of universities

One map. Every university that meet users' requirments will show on the map. After clicking on the university, the website of it will be shown. 

Four plots. There are four interacitve density plots. They will show the average of "Admission Rate", "Average Cost", "Crime Rate Around" and "Salary after Attending" of those selected universities.

### Outlook

![screenshot](doc/Screen Shot 2017-02-23 at 12.45.20 PM.png)

### **Contribution statement**: ([default](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is organized as follows.

```
proj/
├── app/
├── lib/
├── data/
├── doc/
└── output/
```

Please see each subfolder for a README file.

