cloud:
  ssh_key_name: salt
  ssh_key_file: /root/.ssh/id_rsa

  minion:
    master: salt.butt.nz
  
  providers:
    scaleway:
      driver: scaleway
      access_key: 26e74568-4f7e-4e40-bd97-7717b9909319
      token: ba41a1d2-a0c2-4590-af5c-4fa80ce078b0
      key_filename: /root/.ssh/id_rsa

  profiles:
    scaleway_small:
      image: Debian Stretch (9.0)
      location: par1
      commercial_type: VC1S
      enable_ipv6: True
