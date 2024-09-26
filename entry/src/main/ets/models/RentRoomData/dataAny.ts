export interface RentPriceDataAny {
  rentPriceList: any
  rentPrice: any
  isSearch: boolean
  searchRentPrice: any
}

export interface PaymentTypeDataAny {
  paymentTypeList: string[]
  isSearch: boolean
  paymentType: string
  searchPaymentType: string
}

export interface SortDataAny {
  sortList: {
    id: number
    icon: any
    text: string
    orderBy: string
    orderType: string
  }[]
  sort: {
    id: number
    icon: any
    text: string
    orderBy: string
    orderType: string
  }
}