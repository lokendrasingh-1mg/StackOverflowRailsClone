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

### Model

1. devise:
    1. add custom fields to model: https://gist.github.com/withoutwax/46a05861aa4750384df971b641170407
        1. enable scoped_view
        2. `rails g migration add_reputation_to_users reputation:int`
        3. `rails g migration add_name_to_users name:string`
    2. rails g migration doesn't validate attribute type
    3. paranoia to user, question, answer, comment
        1. https://cloudolife.com/2020/09/05/Programming-Language/Ruby/Awesome-Ruby-Gem/Use-paranoia-or-acts_as_paranoid-gem-soft-delete-to-hide-and-restore-records-without-actually-deleting-them/
        2. `rails generate migration AddDeletedAtToUsers deleted_at:datetime:index`
        3. use existing migration:
            1. add `t.datetime :deleted_at, index: true`
            2. `acts_as_paranoid` in `user` model
        4. `User.destroy` updates `deleted_at`
        5. retrieve all deleted by using `User.with_deleted`

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
        1. `rails g model user_vote value:integer votable_id:integer votable_type:string user:references`
        2. and update models respectively
        3. enum to check vote value: https://betterprogramming.pub/how-to-use-enums-in-rails-6-87600e292476
    6. QuestionTag:
        1. Don't generate the model: `rails generate migration CreateJoinTableQuestionsTags questions tags`
        2. Generate the model `rails generate model questions_tags question:references tag:references`
    7. TagUser
        1. Don't generate the model: `rails generate migration CreateJoinTableTagsUsers tags users`
    8. BookmarkQuestions
        1. Generate the model `rails generate model bookmark question:references user:references`
    9. unique constraint to tag:
        1. removed since can be added in same migration `rails generate migration add_index_to_tags name:uniq`
        2. https://stackoverflow.com/questions/1449459/how-do-i-make-a-column-unique-and-index-it-in-a-ruby-on-rails-migration/49813515#49813515

3. insert_all doesn't add time stamp as its not passed through validators
    1. provide default
       time https://stackoverflow.com/questions/1580805/how-to-set-a-default-value-for-a-datetime-column-to-record-creation-time-in-a-mi/68202776#68202776
    2. Use a custom function that add timestamps
    3. Use `ActiveSupport::Concern`
    4. https://codersloth.medium.com/rails-how-to-batch-insert-records-20ea769dcbc4
    5. `class_method do`
       internals https://stackoverflow.com/questions/33326257/what-does-class-methods-do-in-concerns/51932490#51932490

4. Model version using paper trail
    1. `rails generate paper_trail:install`
    2. https://stevepolito.design/blog/paper-trail-gem-tutorial/

### Controller

1. Question:
    1. `rails g controller questions index new create show edit update destroy`
    2. json response: `render json: @questions`
    3. serializer: `rails g serializer question`
    4. https://learn.co/lessons/using-active-model-serializer
2. Answer:
    1. `rails g controller answers index new create show edit update destroy`
    2. json response: `render json: @answers`
    3. serializer: `rails g serializer answer`

3. RSpec
    1. https://medium.com/@agungsetiawan/rails-model-and-service-object-testing-using-rspec-and-factorybot-case-e-money-transfer-a60865b48baf
    2. `rails generate rspec:install`

4. Comments
    1. https://rubyinrails.com/2019/04/23/rails-routes-concerns/
    2. commentable concerns
    3. `rails g controller comments index new create show edit update destroy`
    4. serializer: `rails g serializer comment`

4. Votes
    1. votable concerns
    2. `rails g controller votes index new create show edit update destroy`
    3. serializer: `rails g serializer vote`

# Convention to be followed

1. Structure of the model should be like this.

    1. Extensions
    2. Constants
    3. Attributes
    4. Validations
    5. Associations
    6. Callbacks
    7. Scopes
    8. Custom Validations

# TODO:

1. paper trail model versions: https://github.com/paper-trail-gem/paper_trail
2. factory bot https://github.com/thoughtbot/factory_bot
3. insert all https://github.com/zdennis/activerecord-import
4. polymorphic: true https://guides.rubyonrails.org/association_basics.html#polymorphic-associations
5. scientist tdd: https://github.com/github/scientist
6. thin model via service layer: https://github.com/nicolasblanco/rails_param
7. rail_param: https://github.com/nicolasblanco/rails_param
8. serialization: https://api.rubyonrails.org/classes/ActiveModel/Serialization.html
9. respond_to: https://api.rubyonrails.org/classes/ActionController/MimeResponds.html
10. routes
    1. nested routing
    2. member vs collection
