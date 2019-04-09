rule apt_nix_elf_derusbi
{

    meta:
        
      description = "Rule to detect the APT Derusbi ELF file"
      author = "Marc Rivero | McAfee ATR Team"

    strings:
        $ = "LxMain"
        $ = "execve"
        $ = "kill"
        $ = "cp -a %s %s"
        $ = "%s &"
        $ = "dbus-daemon"
        $ = "--noprofile"
        $ = "--norc"
        $ = "TERM=vt100"
        $ = "/proc/%u/cmdline"
        $ = "loadso"
        $ = "/proc/self/exe"
        $ = "Proxy-Connection: Keep-Alive"
        $ = "Connection: Keep-Alive"
        $ = "CONNECT %s"
        $ = "HOST: %s:%d"
        $ = "User-Agent: Mozilla/4.0"
        $ = "Proxy-Authorization: Basic %s"
        $ = "Server: Apache"
        $ = "Proxy-Authenticate"
        $ = "gettimeofday"
        $ = "pthread_create"
        $ = "pthread_join"
        $ = "pthread_mutex_init"
        $ = "pthread_mutex_destroy"
        $ = "pthread_mutex_lock"
        $ = "getsockopt"
        $ = "socket"
        $ = "setsockopt"
        $ = "select"
        $ = "bind"
        $ = "shutdown"
        $ = "listen"
        $ = "opendir"
        $ = "readdir"
        $ = "closedir"
        $ = "rename"

    condition:
        (uint32(0) == 0x4464c457f) and (all of them)
}

rule apt_nix_elf_derusbi_kernelModule
{

    meta:
      description = "Rule to detect the Derusbi ELK Kernel module"
      author = "Marc Rivero | McAfee ATR Team"

    strings:
        $ = "__this_module"
        $ = "init_module"
        $ = "unhide_pid"
        $ = "is_hidden_pid"
        $ = "clear_hidden_pid"
        $ = "hide_pid"
        $ = "license"
        $ = "description"
        $ = "srcversion="
        $ = "depends="
        $ = "vermagic="
        $ = "current_task"
        $ = "sock_release"
        $ = "module_layout"
        $ = "init_uts_ns"
        $ = "init_net"
        $ = "init_task"
        $ = "filp_open"
        $ = "__netlink_kernel_create"
        $ = "kfree_skb"

    condition:
        (uint32(0) == 0x4464c457f) and (all of them)
}

rule apt_nix_elf_Derusbi_Linux_SharedMemCreation
{

    meta:
      description = "Rule to detect Derusbi Linux Shared Memory creation"
      author = "Marc Rivero | McAfee ATR Team"

    strings:
        $byte1 = { B6 03 00 00 ?? 40 00 00 00 ?? 0D 5F 01 82 }

    condition:
        (uint32(0) == 0x464C457F) and (any of them)
}

rule apt_nix_elf_Derusbi_Linux_Strings
{

    meta:
      description = "Rule to detect APT Derusbi Linux Strings"
      author = "Marc Rivero | McAfee ATR Team"

    strings:
        $a1 = "loadso" wide ascii fullword
        $a2 = "\nuname -a\n\n" wide ascii
        $a3 = "/dev/shm/.x11.id" wide ascii
        $a4 = "LxMain64" wide ascii nocase
        $a5 = "# \\u@\\h:\\w \\$ " wide ascii
        $b1 = "0123456789abcdefghijklmnopqrstuvwxyz" wide
        $b2 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" wide
        $b3 = "ret %d" wide fullword
        $b4 = "uname -a\n\n" wide ascii
        $b5 = "/proc/%u/cmdline" wide ascii
        $b6 = "/proc/self/exe" wide ascii
        $b7 = "cp -a %s %s" wide ascii
        $c1 = "/dev/pts/4" wide ascii fullword
        $c2 = "/tmp/1408.log" wide ascii fullword

    condition:
        uint32(0) == 0x464C457F and ((1 of ($a*) and 4 of ($b*)) or (1 of ($a*) and 1 of ($c*)) or 2 of ($a*) or all of ($b*))
}

rule apt_win_exe_trojan_derusbi
{

   meta:
      description = "Rule to detect Derusbi Trojan"
      author = "Marc Rivero | McAfee ATR Team"

   strings:
        $sa_1 = "USB" wide ascii
        $sa_2 = "RAM" wide ascii
        $sa_3 = "SHARE" wide ascii
        $sa_4 = "HOST: %s:%d"
        $sa_5 = "POST"
        $sa_6 = "User-Agent: Mozilla"
        $sa_7 = "Proxy-Connection: Keep-Alive"
        $sa_8 = "Connection: Keep-Alive"
        $sa_9 = "Server: Apache"
        $sa_10 = "HTTP/1.1"
        $sa_11 = "ImagePath"
        $sa_12 = "ZwUnloadDriver"
        $sa_13 = "ZwLoadDriver"
        $sa_14 = "ServiceMain"
        $sa_15 = "regsvr32.exe"
        $sa_16 = "/s /u" wide ascii
        $sa_17 = "rand"
        $sa_18 = "_time64"
        $sa_19 = "DllRegisterServer"
        $sa_20 = "DllUnregisterServer"
        $sa_21 = { 8b [5] 8b ?? d3 ?? 83 ?? 08 30 [5] 40 3b [5] 72 } // Decode Driver
        $sb_1 = "PCC_CMD_PACKET"
        $sb_2 = "PCC_CMD"
        $sb_3 = "PCC_BASEMOD"
        $sb_4 = "PCC_PROXY"
        $sb_5 = "PCC_SYS"
        $sb_6 = "PCC_PROCESS"
        $sb_7 = "PCC_FILE"
        $sb_8 = "PCC_SOCK"
        $sc_1 = "bcdedit -set testsigning" wide ascii
        $sc_2 = "update.microsoft.com" wide ascii
        $sc_3 = "_crt_debugger_hook" wide ascii
        $sc_4 = "ue8G5" wide ascii
        $sd_1 = "NET" wide ascii
        $sd_2 = "\\\\.\\pipe\\%s" wide ascii
        $sd_3 = ".dat" wide ascii
        $sd_4 = "CONNECT %s:%d" wide ascii
        $sd_5 = "\\Device\\" wide ascii
        $se_1 = "-%s-%04d" wide ascii
        $se_2 = "-%04d" wide ascii
        $se_3 = "FAL" wide ascii
        $se_4 = "OK" wide ascii
        $se_5 = "2.03" wide ascii
        $se_6 = "XXXXXXXXXXXXXXX" wide ascii

   condition:
      (uint16(0) == 0x5A4D) and ( (all of ($sa_*)) or ((13 of ($sa_*)) and ( (5 of ($sb_*)) or (3 of ($sc_*)) or (all of ($sd_*)) or ( (1 of ($sc_*)) and (all of ($se_*)) ) ) ) )
}

