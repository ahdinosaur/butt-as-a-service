cloud:
  minion:
    master: salt.butt.nz
  
  providers:
    scaleway_butt:
      access_key: ${access_key}
      token: ${token}
      driver: scaleway
