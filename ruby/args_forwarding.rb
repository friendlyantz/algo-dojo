def concrete_method(*positional_args, **keyword_args, &block)
  positional_args
  keyword_args
  block.call
end

def forwarding_method(...)
  concrete_method(...)
end

concrete_method(1, b: 2) { puts 3 }
