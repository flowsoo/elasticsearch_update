while true; do
    for p in /proc/[0-9]*; do
        [ -r "$p/cmdline" ] || continue
        cmd=$(tr '\0' ' ' < "$p/cmdline" 2>/dev/null)
        case "$cmd" in
            *org.elasticsearch*|*jdk/bin/java*)
                printf '\nPID=%s\nCMD=%s\n' "${p##*/}" "$cmd"
                readlink "$p/cwd" 2>/dev/null
                ;;
        esac
    done
    sleep 0.05
done
