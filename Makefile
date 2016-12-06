Dockerfile.done: Dockerfile Dockerfile-cupy.done
	docker build . -t cuth
	touch Dockerfile.done

Dockerfile-cupy.done: Dockerfile-cupy
	docker build . -f Dockerfile-cupy -t cupy
	touch Dockerfile-cupy.done

clean:
	rm -f *.done
