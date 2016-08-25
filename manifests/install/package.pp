# Definition: tomcat::install::package
#
# Private define to install Tomcat from a package.
#
# Parameters:
# - $package_ensure is the ensure passed to the package resource.
# - The $package_name you want to install.
# - $package_options to pass extra options to the package resource.
define tomcat::install::package (
  $package_ensure,
  $package_options,
  $package_name = $name,
  $user,
  $group,
  $manage_user,
  $manage_group,
) {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $manage_user {
    ensure_resource('user', $user, {
      ensure => present,
      gid    => $group,
      })
  }
  if $manage_group {
    ensure_resource('group', $group, {
      ensure => present,
      })
  }

  package { $package_name:
    ensure          => $package_ensure,
    install_options => $package_options,
  }
}
