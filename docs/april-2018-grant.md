# butt cloud

_an April 2018 #ssbc-grants proposal_

hi, i'd like to spend a month working on %1TVZigDql9VAQaZZVX/QegKan18urBuXQikOWE1uTMk=.sha256.

## status update

i did maybe 80% of the automated infrastructure work over the holidays using Salt Stack, Open Stack using [OVH public cloud](https://www.ovh.com/world/public-cloud/), and Docker.

i've been able to achieve _mostly_ reliable pubs using an [`ssb-pub`](https://github.com/ahdinosaur/ssb-pub) Docker image (i think the Salt automation will fix the only remaining problem).

## next steps

the first goal is to be able to describe a set of pubs across a set of hubs (servers) using a YAML config file, which is then fed into a Salt Stack master who makes changes to all the minion servers to meet the desired configuration. initially, this will involve manual 

once i can configure  is working

## roadmap

- be able to update a cluster of pubs using a YAML file, with manual cloud provisioning but automatic pub service instantiation.
- create a simple signup and pay flow page
- 

---

maybe just wrap shade: https://docs.openstack.org/shade/latest/user/usage.html

figure out what specific actions need to be done.

- create new hub
- add service to server

figure out what events trigger which actions.

have a message queue, where a python worker pulls an action and does something.

make the payment app first, to collect events.

---

architecture:

- provider app
- provider api
  - users
    - id
    - name
    - email
    - password
  - hubs
  - pubs
    - userId
- hub service
  - list pubs
- pub api
  - send command
  - get status
- orchestrator (cron job to ensure everything is as it should be)
- message queue
- cloud (shade) worker
- docker worker

master orchestrates minions
or
minion orchestrates self
?

use cases:

- when pubs bail on a hub, we want to re-allocate pubs

---

focus on early deliverables:

- 100% reliable pub
  - write a killer in rust that kills when docker container is unhealthy
  - write a healer in rust that reboots when docker container is down

get feedback, is a general cloud provider like OpenStack important?
or should i wrap a cloud provider's API like DigitalOcean?

---
