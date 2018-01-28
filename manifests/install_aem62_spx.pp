define aem_curator::install_aem62_spx (
  $aem_artifacts_base,
  $sp_version_number,
  $aem_healthcheck_version,
  $aem_port,
  $run_mode,
  $tmp_dir,
  $aem_base                = '/opt',
  $aem_id                  = 'aem',
  $aem_jvm_mem_opts        = '-Xss4m -Xmx8192m',
  $aem_sample_content      = false,
  $aem_jvm_opts            = [
    '-XX:+PrintGCDetails',
    '-XX:+PrintGCTimeStamps',
    '-XX:+PrintGCDateStamps',
    '-XX:+PrintTenuringDistribution',
    '-XX:+PrintGCApplicationStoppedTime',
    '-XX:+HeapDumpOnOutOfMemoryError',
  ],
  $post_install_sleep_secs = 120,
) {

  notice("${aem_id}: Install service pack ${sp_version_number}")  
  notice("AEM-6.2-Service-Pack-1-6.2.SP${sp_version_number}.zip")  
  
  aem_curator::install_aem6x { "${aem_id}: Install AEM":
    tmp_dir                 => $tmp_dir,
    run_mode                => $run_mode,
    aem_port                => $aem_port,
    aem_artifacts_base      => $aem_artifacts_base,
    aem_healthcheck_version => $aem_healthcheck_version,
    aem_base                => $aem_base,
    aem_sample_content      => $aem_sample_content,
    aem_jvm_mem_opts        => $aem_jvm_mem_opts,
    aem_jvm_opts            => $aem_jvm_opts,
    post_install_sleep_secs => $post_install_sleep_secs,
    aem_id                  => $aem_id,
    aem_version_number      => 2,
  } -> aem_curator::install_aem_package { "${aem_id}: Install hotfix 11490":
    tmp_dir         => $tmp_dir,
    package_group   => 'adobe/cq620/hotfix',
    package_name    => 'cq-6.2.0-hotfix-11490',
    package_version => '1.2',
    artifacts_base  => $aem_artifacts_base,
    aem_id          => $aem_id,
  } -> aem_curator::install_aem_package { "${aem_id}: Install hotfix 12785":
    tmp_dir                     => $tmp_dir,
    package_group               => 'adobe/cq620/hotfix',
    package_name                => 'cq-6.2.0-hotfix-12785',
    package_version             => '7.0',
    restart                     => true,
    post_install_sleep_secs     => 150,
    post_login_page_ready_sleep => 30,
    artifacts_base              => $aem_artifacts_base,
    aem_id                      => $aem_id,
  } -> aem_curator::install_aem_package { "${aem_id}: Install service pack ${sp_version_number}":
    tmp_dir         => $tmp_dir,
    file_name       => "AEM-6.2-Service-Pack-1-6.2.SP${sp_version_number}.zip",
    package_name    => 'aem-service-pkg',
    package_group   => 'adobe/cq620/servicepack',
    package_version => '6.2.SP${sp_version_number}',
    artifacts_base  => $aem_artifacts_base,
    aem_id          => $aem_id,
  } -> aem_curator::install_aem_package { "${aem_id}: Install hotfix 15607":
    tmp_dir         => $tmp_dir,
    package_group   => 'adobe/cq620/hotfix',
    package_name    => 'cq-6.2.0-hotfix-15607',
    package_version => '1.0',
    artifacts_base  => $aem_artifacts_base,
    aem_id          => $aem_id,
  }

}
