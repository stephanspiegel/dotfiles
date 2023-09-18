local taxify = function(amount)
  return string.format('%.2f', amount * 1.055)
end

return {
  taxify = taxify
}
