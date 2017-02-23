### A Note on Contributions

Whenever we have team projects, there are always concerns on unequal contributions from members of a project team. In the ideal world, we are all here to put in our best efforts and learn together. Even in that ideal world, we have different skill sets and preparations, and we will still contribute differently to a project. 

Therefore, you are required to post a *contribution statement* in the root README.md of your GitHub repo. Please beware that your GitHub repo will become public and remain public after the due date of the projects. 

Post your title, team members, project abstract and a contribution statement in the README.md file.  This is a common practice for research scientific journals. 

Below is an example. If no contribution statement is provided, we will insert a default statement that goes "**All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement**. "

---
Sample project README statement.

Project 2 Open Data App - an RShiny app development project

Team members: Jiahui Tan, Yue Jin, Qingyuan Zhang, Tongyue Liu, Yijia Pan

Summary: This project explores and visualizes 272 universities in America by using the data on ([College Scorecard Database](https://collegescorecard.ed.gov/data/documentation/)) and ([2016 Forbes Ranking](data/ranking_forbes_2016.csv)). We created a Shiny App to help users discover and compare universities. 

+ Filter & Rank——easily discover and compare the universities that meet users' requirements

Two filter parts. One part is the basic filter: they can choose universities upon "Major", "Type of School" and "Type of City". The other part is the advanced filter: they can give their weights to "Academic Performance", "Average Cost", "Earning & Jobs", "Social Security" and "Life Quality". 

Two ranking options. One option is based on "The 2016 Forbes University Rankings". The other one is using the weights users have given before to calculate the rank of these universities. 

+ Map & Plot——vividly show the characters of universities

One map. Every university that meet users' requirments will show on the map. After clicking on the university, the website of it will be shown. 

Four plots. There are four interacitve density plots. They will show the average of "Admission Rate", "Average Cost", "Crime Rate Around" and "Salary after Attending" of those selected universities.

[Contribution Statement] Yijia Pan, Jin Yue and Jiahui Tian respectively found the dataset of college scorecard dataset, university's ranking dataset and crime & happiness score dataset. All team members designed the content of this App. Jiahui Tian, Jin Yue and Qingyuan Zhang merged the data and cleaned the data. Tongyue Liu wrote the fiter, map, ranking shiny UI part. Jiahui Tian wrote the density plot Shiny UI part. Yue Jin wrote the ranking server part. Qingyuan Zhang and Yijia Pan draw the map and density plots and wrote the map server part. Jiahui Tian and Qingyuan Zhang wrote the density plot server part. Yijia Pan summary the folder. Jiahui Tian gave the presentation.
