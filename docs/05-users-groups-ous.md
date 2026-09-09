# Users, Groups, and OUs

## Goal

Demonstrate repeatable identity provisioning with fictional lab data.

## Data files

- `data/groups.sample.csv` defines security groups.
- `data/users.sample.csv` defines fictional users.
- `data/memberships.sample.csv` maps users to groups.

## Script order

1. `04-create-ous.ps1`
2. `05-create-groups.ps1`
3. `06-create-users.ps1`
4. `07-add-users-to-groups.ps1`

## Password behavior

The user-creation script accepts one temporary password as a secure value during the lab run. Each account must change it at first sign-in. No password is stored in a CSV.

## Data rule

Keep all repository identities fictional. Do not use relatives, employers, clients, classmates, or real email addresses as sample data.

