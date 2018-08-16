# Ticketee
Ticketee is a ticket-tracking application to track company projects

## Features
* Tracks tickets (of course) and groups them into projects
* Provides a way to restrict users to certain projects
* Allows users to upload files to tickets
* Lets users tag tickets so they’re easy to find
* Provides an API on which users can base development of their own application

## Roadmap
1. User can create projects and tickets
1. Auth
1. Add comments to tickets
1. Email notification
1. File uploading
1. Ticket comments
1. Tracking Ticket state

## Roles - a User has a specific Role on a Project
- used to determine what actions a user can take on a project/ticket
### Each record tracks:
* a User(who has a specific Role)
* a Project(to which the Role applies)
* the type of Role
### Three types of roles:
* Viewer  - read project but not edit.
* Editor  - read project and create/update tickets on the project.
* Manager - read project, manage tickets, and administrate some facets of the project itself, including editing the project’s details. They won’t be able to delete the project, though - that’s reserved for admins of the site.

## Ticket comments
- Tickets will have comments (only auth'd can comment)

## Ticket State - tickets have a workflow revolving around state changes
- an Admin can add states (but not delete)
  - states don't get deleted once created & used on a Ticket (but can be 'archived')
- has_a :comment => track that a comment ch. the state
- has_a :ticket => track cur. state of ticket
### States (changed via drop-down list):
* new (default)
* open => 'when a developer decides to work on it'
* resolved
* 'need more info'
* duplicate
* invalid
