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
