#!/usr/bin/env gorun
// go.mod >>>
// module github.com/Otus-DevOps-2023-05/voitenkov_infra/ansible
// go 1.20
// require (
//	github.com/bitfield/script v0.22.0 // indirect
//	github.com/itchyny/gojq v0.12.12 // indirect
//	github.com/itchyny/timefmt-go v0.1.5 // indirect
//	mvdan.cc/sh/v3 v3.6.0 // indirect
// )
// <<< go.mod
//
// go.sum >>>
// github.com/bitfield/script v0.22.0 h1:LA7QHuEsXMPD52YLtxWrlqCCy+9FOpzNYfsRHC5Gsrc=
// github.com/bitfield/script v0.22.0/go.mod h1:ms4w+9B8f2/W0mbsgWDVTtl7K94bYuZc3AunnJC4Ebs=
// github.com/creack/pty v1.1.9/go.mod h1:oKZEueFk5CKHvIhNR5MUki03XCEU+Q6VDXinZuGJ33E=
// github.com/creack/pty v1.1.18/go.mod h1:MOBLtS5ELjhRRrroQr9kyvTxUAFNvYEK993ew/Vr4O4=
// github.com/frankban/quicktest v1.14.4/go.mod h1:4ptaffx2x8+WTWXmUCuVU6aPUX1/Mz7zb5vbUoiM6w0=
// github.com/google/go-cmp v0.5.4/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE=
// github.com/google/go-cmp v0.5.9/go.mod h1:17dUlkBOakJ0+DkrSSNjCkIjxS6bF9zb3elmeNGIjoY=
// github.com/google/renameio/v2 v2.0.0/go.mod h1:BtmJXm5YlszgC+TD4HOEEUFgkJP3nLxehU6hfe7jRt4=
// github.com/itchyny/gojq v0.12.12 h1:x+xGI9BXqKoJQZkr95ibpe3cdrTbY8D9lonrK433rcA=
// github.com/itchyny/gojq v0.12.12/go.mod h1:j+3sVkjxwd7A7Z5jrbKibgOLn0ZfLWkV+Awxr/pyzJE=
// github.com/itchyny/timefmt-go v0.1.5 h1:G0INE2la8S6ru/ZI5JecgyzbbJNs5lG1RcBqa7Jm6GE=
// github.com/itchyny/timefmt-go v0.1.5/go.mod h1:nEP7L+2YmAbT2kZ2HfSs1d8Xtw9LY8D2stDBckWakZ8=
// github.com/kr/pretty v0.3.1/go.mod h1:hoEshYVHaxMs3cyo3Yncou5ZscifuDolrwPKZanG3xk=
// github.com/kr/text v0.2.0/go.mod h1:eLer722TekiGuMkidMxC/pM04lWEeraHUUmBw8l2grE=
// github.com/mattn/go-isatty v0.0.17/go.mod h1:kYGgaQfpe5nmfYZH+SKPsOc2e4SrIfOl2e/yFXSvRLM=
// github.com/mattn/go-runewidth v0.0.14/go.mod h1:Jdepj2loyihRzMpdS35Xk/zdY8IAYHsh153qUoGf23w=
// github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod h1:pJLUxLENpZxwdsKMEsNbx1VGcRFpLqf3715MtcvvzbA=
// github.com/rivo/uniseg v0.2.0/go.mod h1:J6wj4VEh+S6ZtnVlnTBMWIodfgj8LQOQFoIToxlJtxc=
// github.com/rivo/uniseg v0.4.4/go.mod h1:FN3SvrM+Zdj16jyLfmOkMNblXMcoc8DfTHruCPUcx88=
// github.com/rogpeppe/go-internal v1.9.0/go.mod h1:WtVeX8xhTBvf0smdhujwtBcq4Qrzq/fJaraNFVN+nFs=
// github.com/rogpeppe/go-internal v1.10.0/go.mod h1:UQnix2H7Ngw/k4C5ijL5+65zddjncjaFoBhdsK/akog=
// golang.org/x/sync v0.1.0/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
// golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod h1:oPkhp1MJrh7nUepCBck5+mAzfO9JrbApNNgaTdGDITg=
// golang.org/x/sys v0.3.0/go.mod h1:oPkhp1MJrh7nUepCBck5+mAzfO9JrbApNNgaTdGDITg=
// golang.org/x/sys v0.5.0/go.mod h1:oPkhp1MJrh7nUepCBck5+mAzfO9JrbApNNgaTdGDITg=
// golang.org/x/term v0.3.0/go.mod h1:q750SLmJuPmVoN1blW3UFBPREJfb1KmY3vwxfr+nFDA=
// golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0=
// gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0=
// gopkg.in/yaml.v3 v3.0.1/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM=
// mvdan.cc/editorconfig v0.2.0/go.mod h1:lvnnD3BNdBYkhq+B4uBuFFKatfp02eB6HixDvEz91C0=
// mvdan.cc/sh/v3 v3.6.0 h1:gtva4EXJ0dFNvl5bHjcUEvws+KRcDslT8VKheTYkbGU=
// mvdan.cc/sh/v3 v3.6.0/go.mod h1:U4mhtBLZ32iWhif5/lD+ygy1zrgaQhUu+XFy7C8+TTA=
// <<< go.sum

package main

import (
	"github.com/bitfield/script"
	"fmt"
)

func main() {
	p := script.File("inventory.json")
	output, err := p.String()
	if err != nil {
		panic(err)
	} else {
		fmt.Println(output)
	}
}
