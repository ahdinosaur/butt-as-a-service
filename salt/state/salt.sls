{% set roles = salt['grains.get']('roles', []) %}
{% if 'salt' in roles %}

{% for salt in ['master', 'minion'] %}
{% if salt in roles %}

/etc/salt/{{salt}}:
  file.managed:
    - source: salt://{{salt}}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        git_pubkey: /root/.ssh/id_rsa
        git_privkey: /root/.ssh/id_rsa.pub
        state_git: git@github.com:ahdinosaur/butt-as-a-service

{% endif %}
{% endfor %}

{% endif %}
