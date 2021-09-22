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
    5. concerns: https://stackoverflow.com/questions/27867124/how-to-use-before-action-in-a-module
    6. pagination: https://github.com/kaminari/kaminari

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

5. Votes
    1. votable concerns
    2. member vs collection: https://rubyinrails.com/2019/07/11/rails-routes-member-vs-collection/
    3. sidekiq
        1. `rails generate job task_vote_count_updater`
        2.

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
6. thin model via service layer
    1. https://medium.com/cratebind/rails-service-layer-for-keeping-models-skinny-too-db5f9f393da2
    2. https://dev.to/aweysahmed/what-are-service-objects-in-ruby-on-rails-should-you-use-it-20o2
    3. https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
    4. https://www.honeybadger.io/blog/refactor-ruby-rails-service-object/
    5. https://blog.engineyard.com/keeping-your-rails-controllers-dry-with-services
7. rail_param: https://github.com/nicolasblanco/rails_param
8. serialization: https://api.rubyonrails.org/classes/ActiveModel/Serialization.html
9. respond_to: https://api.rubyonrails.org/classes/ActionController/MimeResponds.html
10. routes
    1. nested routing
    2. member vs collection
11. https://guides.rubyonrails.org/v3.1/routing.html#static-segments
12. includes vs joins
    1. http://railscasts.com/episodes/181-include-vs-joins?view=asciicast
    2. https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/QueryMethods.html#method-i-eager_load
    3. https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/QueryMethods.html#method-i-includes
    4. https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/QueryMethods.html#method-i-joins
13. pagination: https://github.com/kaminari/kaminari
14. member vs collection: https://rubyinrails.com/2019/07/11/rails-routes-member-vs-collection/
15. use module specific names to avoid diamond inheritance issue
    1. : https://stackoverflow.com/questions/51327319/two-modules-with-same-method-names-included-in-same-class
    2. https://en.wikipedia.org/wiki/Multiple_inheritance#The_diamond_problem
16. Custom Exception:
    1. https://rollbar.com/guides/ruby/how-to-raise-exceptions-in-ruby/
    2. https://stackoverflow.com/questions/1918373/how-do-i-raise-an-exception-in-rails-so-it-behaves-like-other-rails-exceptions/1918405#1918405
17. Ruby guide
    1. https://www.zenspider.com/ruby/quickref.html#general-tips
18. attr_accessor
    1. https://www.rubyguides.com/2018/11/attr_accessor/
19. Sidekiq
    1. https://github.com/mperham/sidekiq/wiki/Best-Practices
    2. https://www.bigbinary.com/learn-rubyonrails-book/background-job-processing-using-sidekiq
    3. https://about.gitlab.com/blog/2020/06/24/scaling-our-use-of-sidekiq/
20. Lazy loading vs eager loading
    1. https://stackoverflow.com/questions/10084355/eager-loading-and-lazy-loading-in-rails/10084865#10084865
    2. Eager: `User.find(:all, :include => :friends)`
    3. Lazy **N + 1**: `users = User.find(:all)`
21. Concern naming convention:
    1. https://dev.to/mainstreet/how-to-name-rails-concerns-3m86
22. Transactions
    1. https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/Transactions/ClassMethods.html
23. Concurrency
    1. https://www.toptal.com/ruby/ruby-concurrency-and-parallelism-a-practical-primer
    2. https://www.honeybadger.io/blog/ruby-concurrency-parallelism/
    3. https://pawelurbanek.com/ruby-concurrent-requests
    4. https://www.bigbinary.com/blog/using-concurrent-ruby-in-a-ruby-on-rails-application
24. Locking
    1. https://gist.github.com/ryanermita/464bf88e2fc292e75c9353820c2f0475
    2. https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/Locking/Optimistic.html
    3. https://blog.kiprosh.com/implement-optimistic-locking-in-rails/
    4. https://dev.to/marcelobarreto/optimistic-lock-on-ruby-on-rails-3n6b
    5. https://www.ibm.com/docs/en/db2/11.5?topic=overview-optimistic-locking
25. Database Locks
    1. Isolation Levels:
        1. https://docs.microsoft.com/en-us/sql/odbc/reference/develop-app/transaction-isolation-levels?view=sql-server-ver15
    2. Optimistic vs Pessimistic
        1. https://stackoverflow.com/questions/129329/optimistic-vs-pessimistic-locking/129397#129397
26. AWS SQS
    1. docker
        1. https://onexlab-io.medium.com/localstack-sqs-a0c36fd13108
        2. installation from official site:
            1. https://apple.stackexchange.com/questions/373888/how-do-i-start-the-docker-daemon-on-macos/373914#373914
        3. docker hangs while starting: https://github.com/docker/for-mac/issues/5113#issuecomment-743330545
        4. health check: `http://localhost:4566/health`
        5. `aws configure`

    ```ruby
    region = 'us-east-1'
    AWS_ACCESS_KEY_ID = '123'
    AWS_SECRET_KEY = 'xyz'
    ```

    2. Queue Usage:
        1. `aws --region us-east-1 --endpoint-url=http://localhost:4566 sqs create-queue --queue-name vote-total-counter`
        2. This should create a queue: `"http://localhost:4566/000000000000/vote-total-counter"`
        3. Messages
            1.
          list all: `aws --endpoint-url=http://localhost:4566 sqs list-queues`
           2.
          send: `aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url http://localhost:4566/000000000000/vote-total-counter --message-body 'Welcome to SQS queue for StackOverflow clone'`
           3. `aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url http://localhost:4566/000000000000/vote-total-counter`
           4. `aws --endpoint-url=http://localhost:4566 sqs delete-queue --queue-url http://localhost:4566/000000000000/vote-total-counter`

# Lol References

> Don’t rescue Exception. EVER. or I will stab you.

1. https://stackoverflow.com/questions/10048173/why-is-it-bad-style-to-rescue-exception-e-in-ruby

> JavaScript ... It gives you enough rope to hang yourself, all you colleagues, and everyone in the building next door.

2. https://news.ycombinator.com/item?id=15641274

> Test-first fundamentalism is like abstinence-only sex ed: An unrealistic, ineffective morality campaign for self-loathing and shaming.
> David is author of rails

3. https://dhh.dk/2014/tdd-is-dead-long-live-testing.html

> Ruby includes a lot of sharp knives in its drawer of features. Not by accident, but by design.

4. https://rubyonrails.org/doctrine/#provide-sharp-knives
