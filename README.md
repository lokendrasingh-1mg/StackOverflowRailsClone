# README

This project is a stack overflow clone written in Rails with postgres database

## Initialising
1. Ensure required database exist
2. start the app using `rails server`
3. This should start the development server on `http://127.0.0.1:3000`

## Features 
1. User, Tag, Question, Answer, Vote, Comment, Bookmark


## Research on stack overflow
1. Multiple answers from same user are allowed but highly frowned
   1. https://meta.stackoverflow.com/questions/251070/are-multiple-answers-by-the-same-user-acceptable
   2. https://meta.stackexchange.com/questions/25209/what-is-the-official-etiquette-on-answering-a-question-twice/25210#25210
2. Deleting account marks the related
   1. question/answer/comments as anonymous
   2. revokes the votes from the user
   3. source: https://stackoverflow.com/help/deleting-account
3. Stack overflow user count
   1. total users: 15,538,945 as of 10 Sept 2021
   2. source: https://data.stackexchange.com/stackoverflow/query/edit/1458638#resultSets
   3. refer: https://meta.stackexchange.com/questions/109573/how-many-users-does-stack-overflow-actually-have

## Learnings/ Commands used
