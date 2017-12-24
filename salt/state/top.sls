base:
  '*':
    - docker
  'roles:master':
    - match: grain
    - salt.master
    - cloud
  'roles:minion':
    - match: grain
    - salt.minion
{#
  'roles:hub'
    - match: grain
    - hub
  'roles:pub'
    - match: grain
    - pub
#}
