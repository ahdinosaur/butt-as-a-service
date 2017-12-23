{% set roles_by_service = {
  'hub': [
    'master'
  ],
  'pub': [
    'minion'
   ]
%}
{% set agents = salt['pillar.get']('agents', []) %}
{% for agent in agents %}

{% if agent.type == 'bot' %}

{% set size = agent.size || 'small' %}
{% set profile = salt['pillar.get']('cloud.profiles_' + size, []) %}

{{agent.name}}:
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
          - salt
          {% for role in roles_by_service[agent.service] %}
          - {{ role }}
          {% endfor %}

{% endif %}

{% endfor %}
