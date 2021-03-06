require 'docking_station.rb'

describe DockingStation do

  it 'docking station releases bike' do
    expect(subject).to respond_to :release_bike
  end

  it 'can I dock a bike' do
      expect(subject).to respond_to(:dock).with(1).arguments
  end

  it 'gets a bike that is working' do
    instance = Bike.new
    expect(instance).to be_working
  end

  it 'releases working bikes' do
    bike = double :bike, broken?: false #working?: true,
    subject.dock bike
    expect(subject.release_bike).to be bike
  end

  describe ' #release_bike' do
    it 'raises an error when there are no bikes available' do
      expect {subject.release_bike}.to raise_error 'No bikes available'
    end

    it ' should NOT release a bike when there are NO bikes available at Docking Station' do
      subject.dock Bike.new
      before_release_counter = subject.bikes.length
      subject.release_bike
      expect(before_release_counter).to eq (subject.bikes.length + 1)
    end


  end

  it 'should not release bike if broken' do
    bike = Bike.new
    bike.report_broken
    subject.dock(bike)
    expect{subject.release_bike}.to raise_error'Bike is broken'
  end

  it 'should release a working bike even if there are broken bikes' do
    subject.dock(Bike.new)
    bike = Bike.new
    bike.report_broken
    subject.dock(bike)
    expect(subject.release_bike).to be_working
  end
  describe ' #dock' do
    it 'will NOT accept bikes when over capacity (default capacity is 20)' do
      #environment
      subject.capacity.times {subject.dock Bike.new}
      #expectation
      expect{subject.dock Bike.new}.to raise_error 'Dock is full'
    end
  end


end
