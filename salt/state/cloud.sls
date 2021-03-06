{% set master = salt['pillar.get']('salt:minion:master') %}
{% set hub = salt['pillar.get']('hub') %}

{% if hub %}

{% set name = hub.name  %}
{% set profile = hub.profile  %}

{{ name }}:
  cloud.profile:
    - profile: {{ profile }}
    - script: bootstrap-salt
    - script_args: -P git develop
    - minion:
        master: {{ master }}
        grains:
          hub: {{ name }}
          roles:
            - minion

{% endif %}
