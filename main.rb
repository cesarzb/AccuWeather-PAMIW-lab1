require './views/view'
require './view_models/view_model'

view_model = ViewModel.new
view = View.new(view_model)

Tk.mainloop
