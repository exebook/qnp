net ∆ ≣ ('net')
cli ∆ ∅
retry ∆ 1

➮ startServer {
	spawn ∆ ≣ ('child_process').spawn
	❸ spawn (__dirname + '/srv', [],
		{ detached: ⦿ , stdio: ['ignore','ignore','ignore']}
	)
	③ on('error', ➮ {
		ロ 'Error while starting server:', a.code
	})
	③ unref()
	setTimeout(➮ { waitServer(onConnect) }, 500)
}

➮ waitServer f {
	cli = net.connect(7000, 'localhost')
	cli.on('connect', f)
	cli.on('error', ➮ {
		retry++
		 // ten seconds is enough for server to load DB (normal is 2 s.)
		if (retry < 100) setTimeout(➮ {waitServer(f)}, 100)
	   else ロ 'I gave up'
	})
}

➮ tryServer {
	cli = net.connect(7000, 'localhost')
	cli.on('error', ➮ {
		ロ 'Server must be started'
		startServer()
	})
	cli.on('connect', ➮ {
		onConnect()
	})
}

stopServer = ➮ stopServer f {
	cli = net.connect(7000, 'localhost')
	cli.on('error', ➮ { f() })
	cli.on('connect', ➮ {
		cli.write('__EXIT__')
		f()
	})
}

term ∆ 'exebook'
cd ∆ 0

➮ onConnect {
	cli.write(term)
	R ∆ ''
	cli.on('data', ➮ {
		R += a ≂
	})
	cli.on('end', ➮ {
		cb(R)
	})
}

queryServer = ➮ queryServer t f {
	term = t
	cb = f
	tryServer()
}

//stopServer(➮ { ロ 'stopped'; })
//queryServer('deodar', ➮ {ロ a;})
