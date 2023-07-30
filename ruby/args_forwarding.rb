def concrete_method(*positional_args, **keyword_args, &block)
  positional_args
  keyword_args
  block.call
end

def args_forwarding_method(...)
  concrete_method(...)
end

