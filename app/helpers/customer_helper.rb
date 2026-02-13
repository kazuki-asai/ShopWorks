module CustomerHelper
  GENDER = {
    "male"=>"男性",
    "female"=>"女性",
    "other"=>"その他"
  }   

  def label_gender(gender)
    GENDER[gender]
  end
end
