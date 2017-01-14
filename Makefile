_cuth.done: cuth/Dockerfile _cupy.done
	docker build cuth -t cuth
	touch _cuth.done

_cupy.done: cupy/Dockerfile
	docker build cupy -t cupy
	touch _cupy.done

clean:
	rm -f *.done
