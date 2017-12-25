hub:
  name: salt.butt.nz
  provider: openstack
  size: small
  seeds:
    - net:ssb.mikey.nz:8008~shs:d64Q93XzBhbr2JCLWkZgvzKwTHMvwFgRdtw4fHFlF5k=
    - net:ssb.rootsystems.nz:8008~shs:L+nPFTMUHWXuchOwuzT6Z8Ea8wD/Rtd7leVRxGaknVk=
  pubs:
    - name: one.butt.nz
      port: 8008
      secret:
        curve: ed25519
        public: VJM7w1W19ZsKmG2KnfaoKIM66BRoreEkzaVm/J//wl8=
        private: {{ PRIVATE }}
