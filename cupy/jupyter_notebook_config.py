import os
from IPython.lib import passwd

c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = int(os.getenv('PORT', 8888))
c.MultiKernelManager.default_kernel_name = 'python2'
if 'PASSWORD' in os.environ:
  c.NotebookApp.password = passwd(os.environ['PASSWORD'])
  del os.environ['PASSWORD']
