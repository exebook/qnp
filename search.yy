startTime ∆ ⚡

arg ∆ process.argv⋃(2)
color ∆ ➮ { $ '\u001b[3'+a+'m'}
end ∆ ➮ { $ '\u001b(B\u001b[m'}
⌥ (arg⁰ ≟ '-up') {
	updateDownload()
//	updateIndex() // indexOnly, to debug
	$
}
⌥ (fs.existsSync(DIR + '/zip.json') ≟ ⦾) {
	ロ 'Local database not initialized, please type:'
	ロ 'qnp -up'
	$
}
longest ∆ arg⁰ ⦙ i ⬌ arg ⌥ (argⁱ⁰ ≠ '-' && argⁱ↥ > longest ↥) longest = argⁱ
op ∆ ''
opts ∆ {K:⦾}
⌥ (arg ↥ > 0) ⧖ (arg⁰ ↥ == 1) {
	t ∆ arg ⬉
	⌥ (t ≟ 'K') opts.K = ⦿
	⥹ (t ≟ 'g') color = ➮ {$''}, end = ➮ {$''}
	⎇ op += t
}
fields ∆ {t:⦿, d:⦿, k:⦿, a:⦿ }
⌥ (op ≠ '') { fields = {}; op⌶('')⬍ (➮ {fields[a]=⦿}) }
q ∆ arg
⌥ (q ≟ ∅ || q ↥ == 0) {
	ロ 'Search local copy of npm database, use '+color(6)+'qnp -up'+end()+' to update.'
	ロ 'USAGE: qnp [-up] [t] [d] [k] [g] <keyword -keyword>'
	ロ 't - title, d - desc., k - keywords'
	ロ '-up - update, download and index 80+ MB file from npmjs.org'
	ロ 'g - disable colors'
	ロ 'default: t d k - all on'
	process.exit()
}

queryServer(unextra(longest), done)

∇ J, L

➮ done s {
	A ∆ s ⌶('\n') ⦙ s = 'json={' + A ⫴('') + '}'
	J = eval(''+s) ⦙ L = eval((''+s).toLowerCase())
	search()
}

➮ unextra { ⌥ (a⁰ ≟ '^') a = a⋃(1) ⦙ ⌥ (a ꕉ ≟ '$') a = a⋃(0,-1) ⦙ $ a }

➮ search {
	∇ q = [], nq = []
	i ⬌ arg {
		argⁱ = argⁱ.toLowerCase()
		⌥ (argⁱ⁰ ≟ '-') nq ⬊ (argⁱ ⋃(1)) ⦙ ⎇ q ⬊(argⁱ)
	}
	R ∆ [], count = 0
	⧗ (∇ u in J) {
		i ∆ u.toLowerCase()
		Q ∆ 0
		j ⬌ q {
			O ∆ Lⁱ
			O.k = O.k ⌶(',') ⧉(➮ {$ '^'+a+'$'}) ⫴(',')
			m ∆ 0
			⌥ (fields.t) ⌥ (('^'+i+'$')≀(qʲ) >= 0) m++
			⌥ (fields.d) ⌥ (O.d≀(qʲ) >= 0) m++
			⌥ (fields.k) ⌥ (O.k≀(qʲ) >= 0) m++
			⌥ (fields.a) ⌥ (('^'+O.a+'$')≀(qʲ) >= 0) m++
			⌥ (m > 0) Q++
		}
		⌥ (Q ≠ q ↥) ♻
		⌥ (opts.K ≟ ⦿ && Lⁱ.k ↥ ≟ 0) ♻
		NQ ∆ 0
		j ⬌ nq {
			⌥ (fields.t) ⌥ (i≀(nqʲ) >= 0) ♻
			⌥ (fields.d) ⌥ (Lⁱ.d≀(nqʲ) >= 0) ♻
			⌥ (fields.k) ⌥ (Lⁱ.k≀(nqʲ) >= 0) ♻
			⌥ (fields.a) ⌥ (Lⁱ.a≀(nqʲ) >= 0) ♻
			NQ++
		}
		⌥ (nq ↥ > 0 && NQ ≠ nq ↥) ♻
		keyw ∆''
		⌥ (Jᵘ.k) {
			keyw = Jᵘ.k ⌶(',')
			⌥ (keyw ↥ > 5) keyw.length = 5, keyw ⬊('...')
			keyw = keyw ⫴(color(7)+'|'+end())
		}
		latest ∆'' ⦙ ⌥ (Jᵘ.l) latest = Jᵘ.l // HOw come empty 'latest' field?
		le ∆ keyw ↥ + i ↥ + Jᵘ.a ↥ + Jᵘ.d ↥ + latest ↥ 
		s ∆ color(3)+ i +end()
		+ ' ' + color(4)+ Jᵘ.a +end() 
		+ ' ' + color(0)+ Jᵘ.d +end() 
		+ ' ' + keyw + ' ' + color(7)+ latest +end()
		ロ s
	//	⌥ (le > process.stdout.columns) ロ
		count++
	}
	⌥ (count > 10) ロ color(7)+ count + ' matches' +end()
//	ロ '0123456789'⌶('')⧉(➮{$color(★(a))+a+end()})⫴('')
	s = 'query time ' + (⚡ - startTime) +' ms'
	⧖ (s ↥ < process.stdout.columns) s = ' ' + s
	ロ color(5) + s + end()
}

