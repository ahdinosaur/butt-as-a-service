# Butt as a Service

_(work in progress)_

what if everyone had a friend in the bot family?

Butt as a Service helps you provision and monitor Scuttlebutt bots in the cloud.

**get started with [INSTALL.md](./INSTALL.md)**

## business

most people seem happy to pay $5 / month.

if we prove a successful value flow, we can scale the ecosystem of Scuttlebutt bot providers, in order to support the ecosystem of Scuttlebutt organizers.

hubs > pubs > rugs

## job stories

- when i want to start a bot,
  - if i haven't been here before: i can register, setup a monthly payment, and name my first bot
  - if i have been here before: i can sign in
- when i come home, i can see a dashboard for my bots
- when i want to monitor a bot, i can see visual data about the pub service
- when i want to update the bot's status, i can stop or restart my bot
- when i want to update the bot's code, i can upgrade or rebuild from the bot's source
- when i want to export a bot, i can retrieve my secret, gossip, log, or blobs

## design

### landing

    ----------------
    =  butt.nz
    ----------------
    [start]

---

### start

    ----------------
    v start        x
    ----------------
    - email
    - password

    [yes]

---

### newbie

    ----------------
    v newbie        x
    ----------------
    welcome!

    - name
    - payment
    - bot
      - name

    [yes]

---

### dashboad

    ----------------
    =  butt.nz
    ----------------
    - [my.butt.nz] #alive
    - [your.butt.nz] #alive

---

### bot: actions

    ----------------
    =  your.butt.nz #alive
    ----------------
    [**actions**] | [status] | [invites]

    - [invite]
    - [restart]
    - [stop]
    - [upgrade]
    - [rebuild]
    - [export]
    - [delete]

---

### bot: status

    ----------------
    =  your.butt.nz #alive
    ----------------
    [actions] | [**status**] | [invites]

    status: alive
    uptime: 100 days
    disk usage: 10 GiB
    bandwidth usage: 100GiB
    memory usage: 100 MiB

---

### bot: invites

    ----------------
    =  your.butt.nz #alive
    ----------------
    [actions] | [status | [**invites**]

    - used
      - alice: ...
      - bob: ...
    - unused
      - carol: ...
      - dan: ...
      - eve: ...

---

## data

### agent

- type
- name
- description
- service

### belongs

- sourceAgentId
- targetAgentId

## services

- public http server
  - /authentication/sign-in
  - /authentication/register
  - /agents
- private http server
  - /agents
- each person agent has many bot agents
- for each person agent, run
  - cloud compute
  - cloud storage
- for each bot agent, run
  - for each pub
    - docker service

### modules

- public http server
  - feathers
  - feathers-authentication
- private http server
  - feathers
- cloud provider: scaleway
- cloud orchestration: saltstack
  - get config: salt.pillar.http_json.ext_pillar
