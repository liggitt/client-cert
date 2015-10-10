package main

import (
	"crypto/tls"
	"fmt"
	"net/http"
)

func main() {
	handler := http.HandlerFunc(func(w http.ResponseWriter, req *http.Request) {
		fmt.Println(req.URL.Path)
		for i, cert := range req.TLS.PeerCertificates {
			fmt.Printf("  %d: %#v\n", i, cert.Subject)
		}
	})

	server := &http.Server{
		Addr:    "0.0.0.0:8443",
		Handler: handler,
		TLSConfig: &tls.Config{
			ClientAuth: tls.RequestClientCert,
		},
	}

	fmt.Println("https://127.0.0.1:8443")

	fmt.Println(server.ListenAndServeTLS("localhost.crt", "localhost.key"))
}
