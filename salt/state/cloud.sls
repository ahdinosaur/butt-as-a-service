{% set hub = salt['pillar.get']('hub') %}
{% if hub %}

{% set name = hub.name  %}
{% set profile = hub.profile  %}

{{ name }}:
  cloud.present:
    - profile: {{ profile }}
    - kwargs:
        minion:
          grains:
            hub: {{ name }}
            roles:
              - minion

{% endif %}
