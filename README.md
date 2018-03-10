# About

Single Page Application written in Elm with Elixir/Phoenix Backend

## Status

[![License](https://img.shields.io/github/license/korczis/the-scratch.svg)](https://github.com/korczis/the-scratch/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/korczis/the-scratch.svg?branch=master)](https://travis-ci.org/korczis/the-scratch)
[![Coverage Status](https://coveralls.io/repos/github/korczis/the-scratch/badge.svg?branch=master)](https://coveralls.io/github/korczis/the-scratch?branch=master)

## Features

### Core

- [ ] Accounting/Monitoring
  - [ ] Metrics
    - [ ] Queries count
    - [ ] Query response time Avg
  - [ ] Global
  - [ ] Per User
  - [ ] GraphQL Calls
  - [ ] REST API Calls
  - [ ] UI
    - [ ] Users
    - [ ] Admins
  - [ ] Scalable
  - [ ] Zero-cost (abstraction)
- [ ] Admin Interface
  - [ ] First created User
- [x] Authentication
  - [ ] Email
  - [x] JWT
  - [x] OAuth
    - [x] Github
    - [x] Google
    - [x] Facebook
    - [x] LinkedIn
    - [x] Twitter
  - [x] Sign In
  - [x] Sign Up
  - [ ] Zero-cost (abstraction)
- [ ] Authorization
  - [ ] Permissions
  - [ ] Roles
  - [ ] ACL / RBAC
  - [ ] UI
  - [ ] Zero-cost (abstraction)
- [x] Bootstrap Integration
  - [x] Carousel
  - [x] Navigation Bar
- [ ] Client Side Logging
- [ ] Configuration
  - [ ] Configuration Discovery
  - [ ] Service Discovery
  - [ ] Zero-cost (abstraction)
- [x] CSRF protection
- [ ] Documentation
  - [ ] Generated - Developers
- [ ] Google Analytics
- [x] Google Maps
- [ ] GraphQL & Friends
  - [ ] GraphQL
  - [ ] GraphiQL
  - [ ] Relay
- [ ] Hot Reloading
- [ ] Internationalization
- [ ] Loading Indicator/Spinner
- [ ] Localization
  - [ ] Server-side
  - [ ] Client-side
  - [ ] Extracted/Generated
  - [ ] Shared (Client & Server)
  - [ ] Zero-cost (abstraction)
- [ ] Multipart Upload
- [x] Persistence (using Abstraction/Ecto)
  - [ ] Migrations
  - [ ] In-memory
  - [ ] No-SQL
    - [ ] Couchbase
  - [ ] SQL
    - [ ] SQLite
    - [x] PostgreSQL
  - [ ] Zero-cost (abstraction)
- [ ] Presentation
  - [ ] Generated HTML5
- [x] Router
- [x] Rust Integration
- [ ] Tests
  - [x] Server-side
    - [x] Coverage
  - [ ] Client-side
    - [ ] Coverage
- [ ] User Management
  - [x] Create User
  - [ ] Read/Get User
  - [ ] Update User
  - [ ] Delete User
- [x] Webpack Integration
  - [x] Development
  - [ ] Production
- [ ] WebSocket
  - [x] Phoenix Websocket Integration
    - [x] Authentication
  - [ ] Push Notifications
    - [ ] Persistent Changes

### Deployment

- [ ] Dockerfile
- [ ] Kubernetes
- [ ] Systemd unit

### Fancy

- [ ] [Stats.js](https://github.com/mrdoob/stats.js/) - JavaScript Performance Monitor

## Prerequisites

- [nodejs](https://nodejs.org/en/)
- [bower](https://bower.io/)
- [elm](http://elm-lang.org/)
- [elixir](https://elixir-lang.org/)
- [phoenix](http://www.phoenixframework.org/)
- [postgresql](https://www.postgresql.org/)

## Getting started

To start your Phoenix app:

- Edit config/config.ex
- Install nodejs dependencies with `npm install`
- Install bower dependencies with `bower install`
- Install elm dependencies with `elm package install`
- Install dependencies with `mix deps.get`
- Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## How to

### Add new page

- Create new sub-folder for component in web/elm/Component folder

## Learn more

### Elm

  - Official website: http://elm-lang.org
  - Docs: http://elm-lang.org/docs
  - Examples: http://elm-lang.org/examples
  - Packages: http://package.elm-lang.org/
  - Community: http://elm-lang.org/community
    - Reddit: http://www.reddit.com/r/elm
    - Slack: http://elmlang.herokuapp.com/
    - Twitter: https://twitter.com/elmlang
    - Real Life: https://www.elmlog.com/meetup_groups
    - Mailing List: https://groups.google.com/forum/?fromgroups#!forum/elm-discuss
    - Contributing: http://elm-lang.org/community#contribute
  
### Elixir

  - Official Website: https://elixir-lang.org/
  - Docs: https://elixir-lang.org/docs.html
  - Learning: https://elixir-lang.org/learning.html
  - Blog: https://elixir-lang.org/blog/
  - Guides: https://elixir-lang.org/getting-started/introduction.html
  - Packages: https://hex.pm/
  - Install: https://elixir-lang.org/install.html
  
### Phoenix

  - Official Website: http://www.phoenixframework.org/
  - Guides: http://phoenixframework.org/docs/overview
  - Docs: https://hexdocs.pm/phoenix
  - Mailing List: http://groups.google.com/group/phoenix-talk
  - Source: https://github.com/phoenixframework/phoenix
