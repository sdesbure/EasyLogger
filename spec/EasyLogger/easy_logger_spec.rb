# encoding: utf-8
require File.join(File.expand_path(File.dirname(__FILE__)), "..", "spec_helper")
require 'easy_logger'

describe EasyLogger do
  before(:each) do
    @easy_logger = EasyLogger::EasyLogger.new
  end
  
  it "should return true with match function when methodes and classes are nil" do
    line = "{test{test{pouet{pouet"
    @easy_logger.match(line,nil,nil,"{").should be_true
  end

  it "should return true with match function when the line match a class and methodes is nil" do
    line = "RtestRtestRclasseRpouetRpouet"
    line2 = "RtestRtestR   classe   RpouetRpouet"
    @easy_logger.match(line,["classe","autre_classe"],nil,"R").should be_true
    @easy_logger.match(line2,["classe","autre_classe"],nil,"R").should be_true
  end
  
  it "should return true with match function when the line match a method and classes is nil" do
    line = "RtestRtestRclasseRMethodeRpouet"
    line2 = "RtestRtestRclasseR Methode   Rpouet"
    @easy_logger.match(line,nil,["methode", "autre_methode"],"R").should be_true
    @easy_logger.match(line2,nil,["methode", "autre_methode"],"R").should be_true
  end
  
  it "should return true with match function when the line match a class and a method" do
    line = "RtestRtestRclasseRMethodeRpouet"
    line2 = "RtestRtestR   classe   R Methode   Rpouet"
    @easy_logger.match(line,["classe","autre_classe"],["methode", "autre_methode"],"R").should be_true
    @easy_logger.match(line2,["classe","autre_classe"],["methode", "autre_methode"],"R").should be_true
  end
  
  it "should return true with match function when the line match a class and a method with a separator at the end of the line" do
    line = "RtestRtestRclasseRMethodeRpouetR"
    line2 = "RtestRtestR   classe   R Methode   RpouetR"
    @easy_logger.match(line,["classe","autre_classe"],["methode", "autre_methode"],"R").should be_true
    @easy_logger.match(line2,["classe","autre_classe"],["methode", "autre_methode"],"R").should be_true
  end
  
  it "should return false with match function when the line match a class but not a method" do
    line = "RtestRtestRclasseRMethodeRpouetR"
    line2 = "RtestRtestR   classe   R Methode   RpouetR"
    @easy_logger.match(line,["classe","autre_classe"],["methodes", "autre_methode"],"R").should be_false
    @easy_logger.match(line2,["classe","autre_classe"],["methodes", "autre_methode"],"R").should be_false
  end
  
  it "should return false with match function when the line match a method but not a class" do
    line = "RtestRtestRclasseRMethodeRpouetR"
    line2 = "RtestRtestR   classe   R Methode   RpouetR"
    @easy_logger.match(line,["classes","autre_classe"],["methode", "autre_methode"],"R").should be_false
    @easy_logger.match(line2,["classes","autre_classe"],["methode", "autre_methode"],"R").should be_false
  end
  
  it "should return false if the separator is not found in the line" do
    line ="13456"
     @easy_logger.match(line,["classes","autre_classe"],["methode", "autre_methode"],"R").should be_false
  end
  
end

