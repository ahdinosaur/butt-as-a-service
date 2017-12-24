{% set hubs = salt['pillar.get']('hub.list', []) %}
{% for hub in hubs %}

{$ set provider = hub.provider  %}
{% set size = hub.size || 'small' %}
{% set profile = salt['pillar.get']('cloud.' + provider + '_' + size, []) %}

{{hub.name}}:
  cloud.present:
    - script: bootstrap-salt
    - script_args: -P git v2017.7.2
    {% for key, value in profile.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}
    - minion:
      grains:
        env: production
        roles:
          - minion
          - hub
          - pub

{% endif %}

{% endfor %}
