# ButtCloud

_an April 2018 #ssbc-grants proposal_

hi, i'd like to spend a month working on a hosted butt provider.

## the story so far

pubs are important ([1](%f6ZRXO2t0rwUw/lq5FpWCHtuHc9406Q37TB+lF9bUbc=.sha256), [2](https://writtenby.adriengiboire.com/2018/03/14/my-first-week-experience-with-scuttlebutt-and-patchwork/), [3](https://twitter.com/nicolasini/status/974364249219727360)), my pub @one.butt.nz is the [last public pub standing]! but i also [want to stop hosting public pubs](%PpBm6onXkKWvnJB3q7Kq5T0yPFkKnOyMMk/oeHom8zY=.sha256)

[over the holidays](%1TVZigDql9VAQaZZVX/QegKan18urBuXQikOWE1uTMk=.sha256), i got maybe 80% of the way towards automated Scuttlebutt pub infrastructure using [Salt Stack](https://docs.saltstack.com/), hosted on Open Stack using [OVH public cloud](https://www.ovh.com/world/public-cloud/). i've also been able to achieve _mostly_ reliable pubs using an [`ssb-pub`](https://github.com/ahdinosaur/ssb-pub) Docker image.

i want to throw away all the [Salt Stack](https://docs.saltstack.com/) work i did and start over with [Docker Swarm](https://docs.docker.com/engine/swarm/).

## goals

- build an open source business on Scuttlebutt!
- a pub is [your personal cloud device](%Gwqklkj0b2CBT5tPiz5170NWsPp3xiuLbOImEaG/e+4=.sha256) that is always available and publicly accessible
- a pub should be affordable (start pricing at ~$7/month per pub, try to get to ~$1/month per pub)
- support open source infrastructure providers, like [OVH](https://www.ovh.com/world/public-cloud/) and [Catalyst](http://catalyst.net.nz/catalyst-cloud)

## architecture

- provider service
  - web app
    - join
      - land
      - sign in
      - create pub
      - pay for pub
      - start pub service
    - monitor
      - land
      - sign in
      - view pub
      - see stats
    - command
      - land
      - sign in
      - view pub
      - run command
  - web api
    - users
      - id
      - name
      - email
    - pub
      - bots
        - id
        - userId
        - name
        - status (up, down, none)
      - stats 
        - stream Docker stats
      - commands
        - relay commands to pub services
      - orchestrator
        - on schedule, check what pubs are up
        - have 1 pub per 1 GB memory, 1 hub per 15 GB memory
        - queue worker jobs to ensure correct swarm
    - payment
      - products
      - plans
      - customers
      - subscriptions
  - swarm worker
    - manage hub [machines](https://docs.docker.com/machine/drivers/openstack/)
      - create hub
      - destroy hub
    - manage pub [services](https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/)
      - ensure pub service is up
      - ensure pub service is down
  - mailer worker
- pub service


## stack

- provider service
  - web api
    - [@feathersjs/socketio](https://github.com/feathersjs/socketio)
    - [@feathersjs/authentication](https://github.com/feathersjs/authentication)
    - [@feathersjs/authentication-jwt](https://github.com/feathersjs/authentication-jwt)
    - [feathers-stripe](https://github.com/feathersjs-ecosystem/feathers-stripe)
    - [node-resque](https://github.com/taskrabbit/node-resque)
    - [docker-remote-api](https://github.com/mafintosh/docker-remote-api)
  - web app
    - [next.js](https://github.com/zeit/next.js/)
    - [ramda](http://ramdajs.com/docs/)
    - [@feathersjs/socketio-client](https://github.com/feathersjs/socketio-client)
    - [@feathersjs/authentication-client](https://github.com/feathersjs/authentication-client)
    - [react](https://facebook.github.io/react)
    - [react-hyperscript](https://github.com/mlmorg/react-hyperscript)
    - [recompose](https://github.com/acdlite/recompose)
    - [fela](https://github.com/rofrischmann/fela)
    - [material-ui](https://material-ui.com/)
    - [react-stripe-elements](https://github.com/stripe/react-stripe-elements)
  - swarm worker
    - [node-resque](https://github.com/taskrabbit/node-resque)
    - [docker-remote-api](https://github.com/mafintosh/docker-remote-api)
  - mailer worker
    - [node-resque](https://github.com/taskrabbit/node-resque)
    - [nodemailer](https://github.com/nodemailer/nodemailer)
    - third-party: [sendgrid](https://sendgrid.com/)
    - dev tool: [maildev](https://github.com/djfarrelly/maildev)
- [pub service](http://github.com/ahdinosaur/ssb-pub)
  - [scuttlebot](https://github.com/ssbc/scuttlebot)
  - [ssb-viewer](%MeCTQrz9uszf9EZoTnKCeFeIedhnKWuB3JHW2l1g9NA=.sha256)
  - [git-ssb-web](%q5d5Du+9WkaSdjc8aJPZm+jMrqgo0tmfR+RcX5ZZ6H4=.sha256)

---

## roadmap

1. update `ssb-pub` to use docker-compose, so we can host multiple Scuttlebutt processes in the same service
  1. add `ssb-viewer` to pub service
1. setup docker swarm
  1. setup single "manager" to be docker swarm manager
    1. deploy postgres db on "manager"
    1. deploy redis db on "manager"
  1. setup many "worker"s to be docker swarm workers
1. deploy simple provider apion "manager"
1. deploy simple provider app on "manager"
1. copy or create Terms of Service & Privacy Policy

---

## business

- terms of service & privacy policy
  - copy from https://getterms.io/
  - 

i will be operating this as a personal business: ButtCloud.org



 B2-15
	
15 GB of RAM
	
4 vCores
	
2.3 GHz
	
100 GB

Local SSD RAID
	
250 Mbps public guaranteed

Up to 1000 Mbps vRack
	
$50.40/month

Linux


Classic Volume

Triple replication

200 IOPS* guaranteed

From
$0.045
/month/GB

Cost Calculator
 4 vCPU, 16 GB RAM w/  instances/

subtotal: $285.63
 Standard tier w/  Gigabyte/

subtotal: $97.24
 Network w/  networks/

 Router w/  routers/

 Over the Internet to and from countries outside NZ w/  Gigabytes
subtotal: $30.00

Total: $412.87
