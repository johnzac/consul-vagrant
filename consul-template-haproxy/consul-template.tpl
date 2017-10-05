global
        log /dev/log    local0
        log /dev/log    local1 notice
        user root
        group root
        daemon
defaults
        mode    tcp
        balance leastconn
        timeout client      30000ms
        timeout server      30000ms
        timeout connect      3000ms
        retries 3
frontend default1
        bind 127.0.0.1:8123
        default_backend bk_serverdefault
backend bk_serverdefault
        server defbkend 127.0.0.1:77 maxconn 2048
{{ range services }}
{{ if keyExists (print "expose_service/" .Name "/port") }}
frontend {{ .Name }}
        bind 0.0.0.0:{{ key (print "expose_service/" .Name "/port") }}
        default_backend {{ (print "bk_server" .Name) }}
backend {{ (print "bk_server" .Name) }}
{{ range service .Name }}
        server {{ .Name }}{{ .Address }}{{ .Port }} {{ .Address }}:{{ .Port }} maxconn 2048
{{ end }}{{ end }}{{end}}
