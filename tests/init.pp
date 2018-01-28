class test_install_aem_profile() {
aem_curator::install_aem_profile2 { "Test install AEM":
  aem_artifacts_base      => $::cwd,
  aem_base                => $::cwd,
  aem_healthcheck_version => '1.3.4',
  aem_host                => 'localhost',
  aem_id                  => 'author62',
  aem_port                => 4502,
  aem_profile             => 'aem62_sp4_cfp23',
  aem_sample_content      => false,
  aem_ssl_port            => 5432,
  post_install_sleep_secs => 20,
  run_mode                => 'author',
  tmp_dir                 => '/tmp',
}
}

include test_install_aem_profile
  