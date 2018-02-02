#       It has to be definition instead of class due to the need to support multiple AEM instances
#       on the same machine.
define aem_curator::install_aem_profile (
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
  # extract aem version number
  $aem_version = $profile_tokens[0]
  if ($aem_version != $profile_tokens[-1]) {
    # extract service pack version number
    $sp_version = $profile_tokens[1]
    if ($sp_version != $profile_tokens[-1]) {
      # extract cumulative fix pack version number
      $cfp_version = $profile_tokens[2]

      # install aem + service pack + cumulative fix pack
      if ($aem_version[-1] == '2') {
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
      } elsif ($aem_version[-1] == '3') {
        aem_curator::install_aem63_spx_cfpx { "${aem_id}: Install AEM profile ${aem_profile}":
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
        fail("${aem_version} is not supported!")
      }
    } else {
      # no cumulative fix pack to install, just install aem + service pack
      if ($aem_version[-1] == '2') {
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
      } elsif ($aem_version[-1] == '3') {
        aem_curator::install_aem63_spx { "${aem_id}: Install AEM profile ${aem_profile}":
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
      } else {
        fail("${aem_version} is not supported!")
      }
    }
  } else {
    # no service pack to install, just install plain aem6x.
    aem_curator::install_aem6x { "${aem_id}: Install AEM profile ${aem_profile}":
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
}
