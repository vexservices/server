class StatusTypes < EnumerateIt::Base
  associate_values(
    newer: 0,
    wait_payment: 1,
    paid: 2,
    billed: 3,
    transported: 4,
    delivered: 5,
    canceled: 6,
    unfolded: 7,
    in_dispute: 8,
    refunded: 9
  )
end