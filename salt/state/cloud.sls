{% set hub = salt['pillar.get']('hub') %}
{% if hub %}

{% set name = hub.name  %}
{% set profile = hub.profile  %}

{{ name }}:
  cloud.present:
    - profile: {{ profile }}
    - kwargs
      - script: bootstrap-salt
      - script_args: -P git v2017.7.2
      - minion:
          grains:
            hub: {{ name }}
            roles:
              - minion

{% endif %}
