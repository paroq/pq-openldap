include $(PQ_FACTORY)/factory.mk

pq_part_name := openldap-2.4.44
pq_part_file := $(pq_part_name).tgz

pq_openldap_configuration_flags += --prefix=$(part_dir)
pq_openldap_configuration_flags += --disable-static
pq_openldap_configuration_flags += --enable-dynamic
pq_openldap_configuration_flags += --with-tls=openssl
pq_openldap_configuration_flags += --enable-dynamic
pq_openldap_configuration_flags += --enable-slapd
pq_openldap_configuration_flags += --enable-modules
pq_openldap_configuration_flags += --enable-backends=mod
pq_openldap_configuration_flags += --disable-ndb
pq_openldap_configuration_flags += --disable-sql
pq_openldap_configuration_flags += --disable-shell
pq_openldap_configuration_flags += --disable-bdb
pq_openldap_configuration_flags += --disable-hdb
pq_openldap_configuration_flags += --enable-overlays=mod

build-stamp: stage-stamp
	$(MAKE) -j1 -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -j1 -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) INSTALL_PREFIX=$(stage_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure $(pq_openldap_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
