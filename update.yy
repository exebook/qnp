updateDownload = ➮ updateDownload {
	⌥ (!fs.existsSync(DIR)) fs.mkdirSync(DIR)
	http ∆ ≣ ('http'); URL ∆ 'http://registry.npmjs.org/-/all'
	S ∆ fs.createWriteStream(DIR + 'npm-all-cache.json')
	ロ 'initiating download of DB'
	request ∆ http.get(URL, ➮ {
		done ∆ 0 ⦙ all ∆ ★(a.headers['content-length'])
		a.on('data', ➮ {
			done += a.length
			process.stdout.write( '\r' + (done / (all/100)).toFixed(2)+'%  ' )
		})
		ロ 'download started'
		a.pipe(S)
		S.on('finish', ➮ { 
			ロ 'download complete, indexing'
			S.close(updateIndex)
		})
	})
}

updateIndex = ➮ updateIndex {
	ロ 'loading (5 to 50 seconds)...'
	J = require(DIR + '/npm-all-cache.json')
	ロ 'ok. parsing...'
	R = {}
	⧗ (∇ i in J) if (Jⁱ.name && Jⁱ.description) {
		O ∆ { d: Jⁱ.description }
		O.a = Jⁱ.maintainers⁰.name
		if (Jⁱ.keywords && Jⁱ.keywords.join) O.k = Jⁱ.keywords ⫴(',')
		else O.k = ''
		O.l = Jⁱ['dist-tags'].latest
		Rⁱ = O
	}
	ロ 'ok. indexing...'
	T = [] ⦙ ⧗ (i in R) {
		s = "'" + i + "'"
		T ⬊ (s + ':' + ꗌ(Rⁱ)+',\n')
	}
	s = T⫴('')
	ロ 'ok. saving...'
	fs.writeFileSync(DIR + '/zip.json', s)
	ロ 'ok.'
	stopServer(➮ {
		ロ 'Update complete OK.'
	})
}

➮ mkFastMiniDB {
	R = {}
	⧗ (var i in J) {
		⌥ (⚂ < 0.01 || i == 'elfu' || i == 'deodar') Rⁱ = Jⁱ
	}
	s = ꗌ(R)
	fs.writeFileSync(DIR + '/mini.json', s)
}
//updateDownload()
//updateIndex()
