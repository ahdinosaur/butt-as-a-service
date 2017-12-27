{% set roles = salt['grains.get']('roles', []) %}

{% if 'master' in roles or 'minion' in roles %}
pip:
  pkg.installed:
    - pkgs:
      - build-essential
      - python-setuptools
      - python-dev
      - python-pip
{% endif %}

{% if 'master' in roles %}
wheel:
  pip.installed:
    - require:
      - pkg: pip

shade:
  pip.installed:
    - require:
      - pip: wheel

gitfs:
  pkg.installed:
    - pkgs:
      - git 
      - python-pygit2
{% endif %}
