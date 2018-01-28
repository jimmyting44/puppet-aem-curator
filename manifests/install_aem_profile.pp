#       It has to be definition instead of class due to the need to support multiple AEM instances
#       on the same machine.
define aem_curator::install_aem_profile2 (
  $aem_artifacts_base,
  $aem_healthcheck_version,
  $aem_host,
  $aem_port,
  $aem_profile,
  $aem_ssl_port,
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

  $profile_tokens = split($aem_profile, '_')
  # notice($aem_profile)
  # notice($profile_tokens)
  # notice($profile_tokens[0])
  # $profile_tokens.each |$token| {
  #   notice($token)
  # }
  $aem_version = $profile_tokens[0]
  notice("aem: $aem_version")
  if ($aem_version != $profile_tokens[-1]) {
    # parse service pack
    $sp_version = $profile_tokens[1]
    if ($sp_version != $profile_tokens[-1]) {
      # install aem + service pack + cumulative fix pack
      $cfp_version = $profile_tokens[2]
      notice("Installing aem6${aem_profile[-1]}, sp: $sp_version, cfp: ${cfp_version[-1]}")
      aem_curator::install_aem62_spx_cfpx { "${aem_id}: Install AEM profile ${aem_profile}":
        aem_artifacts_base      => $aem_artifacts_base,
        sp_version_number       => $sp_version[-1],
        cfp_version_number      => $cfp_version[-1],
        aem_base                => $aem_base,
        aem_healthcheck_version => $aem_healthcheck_version,
        aem_id                  => $aem_id,
        aem_jvm_mem_opts        => $aem_jvm_mem_opts,
        aem_port                => $aem_port,
        aem_sample_content      => $aem_sample_content,
        aem_jvm_opts            => $aem_jvm_opts,
        post_install_sleep_secs => $post_install_sleep_secs,
        run_mode                => $run_mode,
        tmp_dir                 => $tmp_dir,
      }
    } else {
      # no cumulative fix pack to install, just aem + service pack
      notice("Installing aem6${aem_profile[-1]}, sp: $sp_version")
      aem_curator::install_aem62_spx { "${aem_id}: Install AEM profile ${aem_profile}":
        aem_artifacts_base      => $aem_artifacts_base,
        sp_version_number       => $sp_version[-1],
        aem_base                => $aem_base,
        aem_healthcheck_version => $aem_healthcheck_version,
        aem_id                  => $aem_id,
        aem_jvm_mem_opts        => $aem_jvm_mem_opts,
        aem_port                => $aem_port,
        aem_sample_content      => $aem_sample_content,
        aem_jvm_opts            => $aem_jvm_opts,
        post_install_sleep_secs => $post_install_sleep_secs,
        run_mode                => $run_mode,
        tmp_dir                 => $tmp_dir,
      }

    }
  } else {
    # no service pack to install, just plain aem6x.
    notice("Installing aem6${aem_profile[-1]}")
    aem_curator::install_aem6x { "${aem_id}: Installing AEM profile ${aem_profile}":
      aem_artifacts_base      => $aem_artifacts_base,
      aem_version_number      => $aem_version[-1],
      aem_base                => $aem_base,
      aem_healthcheck_version => $aem_healthcheck_version,
      aem_id                  => $aem_id,
      aem_jvm_mem_opts        => $aem_jvm_mem_opts,
      aem_port                => $aem_port,
      aem_sample_content      => $aem_sample_content,
      aem_jvm_opts            => $aem_jvm_opts,
      post_install_sleep_secs => $post_install_sleep_secs,
      run_mode                => $run_mode,
      tmp_dir                 => $tmp_dir,
    }
  }

  # if ($aem_version == 'aem62') {
  #   
  #   } elsif ($cfp_version == undef) {
  #     notice("aem_curator::install_aem62_sp")
  #     # aem_curator::install_aem62_sp
  #   } else {
  #     notice("aem_curator::install_aem62_sp_cfp")
  #     # aem_curator::install_aem62_sp_cfp
  #   }
  # } elsif ($aem_version == 'aem63') {
  # } elsif ($cfp_version == undef) {
  #   notice("aem_curator::install_aem62_sp")
  #   # aem_curator::install_aem62_sp
  # } else {
  #   notice("aem_curator::install_aem62_sp_cfp")
  #   # aem_curator::install_aem62_sp_cfp
  # }
}
