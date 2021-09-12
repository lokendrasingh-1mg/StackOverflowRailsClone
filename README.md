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

1. devise:
    1. add custom fields to model: https://gist.github.com/withoutwax/46a05861aa4750384df971b641170407
        1. enable scoped_view
        2. `rails g migration add_reputation_to_users reputation:int`
        3. `rails g migration add_name_to_users name:string`
    2. rails g migration doesn't validate attribute type

2. add model
    1. question: `rails g model Question heading:string description:string votes:integer user:references`
    2. answer: `rails g model Answer content:string votes:integer user:references question:references`
    3. tag: `rails g model Tag name:string`
    4. comment
        1. `rails g model Comment content:string votes:integer commentable_id:integer commentable_type:string user:references`
        2. add ```belongs_to :commentable, polymorphic: true``` to comment model
        3. add ```has_many :comments, as: :commentable``` to relevant models
        4. source: https://betterprogramming.pub/polymorphic-associations-in-rails-72a91ae1a9dd
    5. uservote
        1. `rails g model Uservote value:integer votable_id:integer votable_type:string user:references`
        2. and update models respectively

    6. QuestionTag:
        1. Don't generate the model: `rails generate migration CreateJoinTableQuestionsTags questions tags`
        2. Generate the model `rails generate model questions_tags question:references tag:references`
    7. TagUser
        1. Don't generate the model: `rails generate migration CreateJoinTableTagsUsers tags users`
    8. BookmarkQuestions
        1. Generate the model `rails generate model bookmark question:references user:references`
    9. unique constraint to tag: `rails generate migration add_index_to_tags name:uniq`

3. insert_all doesn't add time stamp as its not passed through validators
    1. Use a custom function that add timestamps
    2. Use `ActiveSupport::Concern`
    3. https://codersloth.medium.com/rails-how-to-batch-insert-records-20ea769dcbc4
    4. `class_method do`
       internals https://stackoverflow.com/questions/33326257/what-does-class-methods-do-in-concerns/51932490#51932490
